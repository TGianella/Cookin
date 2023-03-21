require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "is valid and is an instance of User" do 
    user = User.new(email: "test@test.com", password: "foobar")
    assert user.save
    assert_instance_of User, user
  end

  test "should not be validate with blank password and empty email" do 
    user = User.new()
    assert_not user.save
  end

  test "First_name length validation" do 
    user = User.new(email: "test@test.com", password: "foobar", first_name: "ab")
    assert_not user.save, "User saved, should not (less than 3 chars)"
    user.first_name = "A"*26
    assert_not user.save, "User saved, should not (more than 25 chars)"
    user.first_name = "Théo"
    assert user.save, "User not saved, should be saved because first_name length between 3 .. 25"
  end

  test "validation first_name format" do
    user = User.new(email: "test@test.com", password: "foobar", first_name: "123")
    assert_not user.save, "User saved, should not because first_name contain numbers"
    user.first_name = "Thèo"
    assert user.save, "User not saved, should be saved because only words chars"
  end

  test "Phone number format validation" do
    user = User.new(email: "test@test.com", password: "foobar", phone_number: "123456789")
    assert_not user.save, "User saved with invalid length phone_number, less than 10"
    user.phone_number = "12345678910"
    assert_not user.save, "User saved with invalid length phone_number, more than 10 "
    user.phone_number = "azerty" 
    assert_not user.save, "User saved with invalid type of string"
    user.phone_number = "0650968963"
    assert user.save, "User not saved with correct phone_number"
    user.phone_number = "9650968963"
    assert_not user.save, "User saved with phone_number begin with wrong number "
  end

  test "birth date validation" do
    user = User.new(email: "test@test.com", password: "foobar", birth_date: "1995-05-09")
    assert user.save, "User not saved with correct birth_date"
    user.birth_date = "1850-05-09"
    assert_not user.save, "User save with a datetime impossible"
    user.birth_date = DateTime.now - (10*365)
    assert_not user.save, "User save with age under 18"
  end

  test "admin validation" do
    user = User.new(email: "test@test.com", password: "foobar")
    assert user.is_admin == false, "is_admin status is not false by default"
  end

end