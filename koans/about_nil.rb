require 'edgecase'

class AboutNil < EdgeCase::Koan
  def test_nil_is_an_object
    assert nil.is_a?(Object), "Unlike NULL in other languages"
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    #
    #  What is the Exception that is thrown when you call a method that
    #  does not exist?  
    #
    #  Hint:  launch irb and try the code in the block below.  
    # 
    #  Don't be confused by the code below yet.  It's using blocks 
    #  which are explained later on in about_blocks.rb.  For now,
    #  think about it like running nil.some_method_nil_doesnt_know_about
    #  in a sandbox and catching the error class into the exception
    #  variable.  
    #

    exception = assert_raise(NoMethodError) do
      nil.some_method_nil_doesnt_know_about
    end
    
    # 
    #  What is the error message itself? What substring or pattern could 
    #  you test against in order to have a good idea what the string is?
    #  
    expected_message = "undefined method"
    
    assert_match expected_message, exception.message
    # very cool to see the match method have a regex built in to match on substring.
  end

  def test_nil_has_a_few_methods_defined_on_it
    empty_string = String.new("")
    nil_string = String.new("nil")
    
    assert_equal true, nil.nil?
    assert_equal empty_string, nil.to_s
    assert_equal nil_string, nil.inspect

    # THINK ABOUT IT:
    #
    # Is it better to use
    #    obj.nil?
    # or
    #    obj == nil
    # Why?
    
    # from my limited understanding right now, they both appear to be the same.  Both will
    # check the object for a nil value.  I guess if nil is an object the obj == nil check might return a false positive?
    # maybe the obj.nil? is a better check if you truly want to check if an object is null?
  end

end
