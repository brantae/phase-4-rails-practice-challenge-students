class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: true
    validates :age, numericality: {
        greater_than_or_equal_to: 18,
        message: "must be at least 18 years old"
    }
end
