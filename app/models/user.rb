class User < ActiveRecord::Base
	has_many :articles
	before_save { self.email = email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :username, presence: true, length: {minimum: 3, maximum: 50},uniqueness: { case_sensitive: false }
	validates :email, presence: true, length: {minimum: 3},uniqueness: { case_sensitive: false },format: { with: VALID_EMAIL_REGEX }
	has_secure_password
end
