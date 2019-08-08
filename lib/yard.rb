# frozen_string_literal: true

# YARD customizations

# Define a new +@delegate+ tag. See DefDelegatorHandler for usage.
YARD::Tags::Library.define_tag('Delegate to another method', :delegate)

# Automatically document def_delegator methods
#
# The easiest way to document methods defined with def_delegator is to let the
# system infer everything. By default, if no doc-string comment is present, the
# handler will automatically guess the target method. To do so, the attribute
# (first parameter of def_delegator) must be defined with a type in the
# documentation of the class constructor.
#   # @!method initialize(foo:)
#   #
#   # @param foo [MyClass] yet another attribute   # <= the target class will be inferred from here
#   schema do
#     ...
#   end
#   def_delegator :@foo, :target_method, :my_new_method
#
# In the example above, the handler will infer the class of @foo from the
# comment of the constructor (@foo is an instance of MyClass), and use the name
# of the target method (second argument of def_delegator). So the target is
# +MyClass#target_method+.
#
# It is also possible to manually set the target method by using the +@delegate+ tag.
#   # @delegate MyClass#target_method
#   def_delegator :@foo, :target_method, :my_new_method
#
# Once the target method has been identified (automatically or manually), the
# +return+ and +param+ tags will be automatically copied. It will also add a
# +see+ tag pointing to the target method.
class DefDelegatorHandler < YARD::Handlers::Ruby::Base
  handles method_call(:def_delegator)
  namespace_only

  process do
    # Parse statement
    target_attribute = statement.parameters[0].jump(:ivar).source.tr('@', '')
    target_method = statement.parameters[1].jump(:ident).source
    method_name = statement.parameters[2].jump(:tstring_content, :ident).source

    # Build YARD MethodObject
    yard_object = YARD::CodeObjects::MethodObject.new(namespace, method_name)

    # Register the new MethodObject
    register(yard_object)

    # Build YARD Proxy to the target method
    target_path = if yard_object.tag('delegate')
                    yard_object.tag('delegate').text
                  else
                    # find the class of the attribute in the documentation of the constructor method
                    target_klass = YARD::Registry.resolve(namespace, '#initialize').tags('param').detect { |tag| tag.name == target_attribute }.types.first
                    "#{target_klass}##{target_method}"
                  end
    proxy = YARD::CodeObjects::Proxy.new(namespace, target_path)

    # Reference the tags to the proxy
    %w[param return].each do |tag_name|
      yard_object.add_tag(YARD::Tags::RefTagList.new(tag_name, proxy))
    end

    # Add a +see+ tag
    yard_object.add_tag(YARD::Tags::Tag.new('see', nil, nil, target_path))
  end
end
