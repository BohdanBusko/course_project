class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :category

  validates :name, :description, :start_date, presence: true
  validates :name, length: { minimum: 5, maximum: 100 }
  validates :description, length: { minimum: 20, maximum: 500 }

  field :name, type: String
  field :description, type: String
  field :start_date, type: Date
  field :started, type: Mongoid::Boolean

  def self.change_status
    all.each do |course|
      course.update_attribute(:started, true) if course.start_date < Date.today
    end
  end
end
