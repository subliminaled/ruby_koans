require 'edgecase'

class AboutHashes < EdgeCase::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]
    assert_equal "dos", hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "eins", :two => "dos" }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
    
    # I tend to try to use objects more often than literals.  I can test the equality of the total object, not just its value
    # plus I can also change the values of expected and keep the assert using the variable
    
    # I just ran it through irb and it fails using a literal instead of variable.  It seems that the ruby intepreter is trying to parse the
    # literal as some other entity versus resolving it to be a hash object.  I have to be honest, I'm not 100% sure why yet.
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    assert_equal hash1, hash2    
  end

  def test_hash_keys_and_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal [:one, :two], hash.keys
    assert_equal ["uno","dos"], hash.values
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_not_equal hash, new_hash
    
    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal expected, new_hash
  end
end
