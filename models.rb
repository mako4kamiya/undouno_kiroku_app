class User < ActiveRecord::Base
    validates :name, presence: true , uniqueness: true
    validates :password, presence: true
end

class Muscle < ActiveRecord::Base
    validates :part, presence: true
    validates :min, presence: true
    validates :user_id, presence: true
end
