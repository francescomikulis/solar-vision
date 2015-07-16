require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.name = "a" * 256
    assert_not @user.valid?
  end
  
  test "email validation should accept only VALID addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "Address #{valid_address.inspect} should be VALID"
    end
  end
  
  test "email validation should reject INVALID addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "Address #{invalid_address.inspect} should be NOTVALID"
    end
  end
  
  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?, "Address #{duplicate_user.email} should be UNIQUE"
  end
  
  test "email address should be lowercase" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.downcase
    @user.save
    assert duplicate_user.email == @user.email, "Address #{duplicate_user.email} should be LOWERCASE"
  end
  
  test "password should have a minimum lenght" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?, "Password #{@user.password} should be LONGER"
  end
  
  test "password validation should accept only VALID passwords" do
    valid_passwords = %w[] #PROBLEM
    valid_passwords.each do |valid_password|
      @user.password = valid_password
      assert @user.valid?, "Password #{valid_password.inspect} should be VALID"
    end
  end
  
  test "password validation should reject INVALID passwords" do
    invalid_passwords = %w[dsawda ajduh1 gkjnfau/ sadnun& SDEFI3 kj32146]
    invalid_passwords.each do |invalid_password|
      @user.password = invalid_password
      assert_not @user.valid?, "Password #{invalid_password.inspect} should be NOTVALID"
    end
  end
  
  test "authenticated? Should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated microposts should be dostroyed" do
    @user.save
    @user.microposts.create!(content: "Hello")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  test "should follow and unfollow a user" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
  
  test "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Post from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Post from unfollowed user not shown
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
  
end