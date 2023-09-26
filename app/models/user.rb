class User < ApplicationRecord
    has_secure_password

    before_validation :set_default_role, on: :create

    belongs_to :role
    
    validates :email, presence: true
    validates :password, presence: true

    private
    
    def set_default_role
        self.role ||= Role.find_or_create_by(name: 'Normal')
    end
end
