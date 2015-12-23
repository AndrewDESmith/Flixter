class User < ActiveRecord::Base
  has_many :courses
  has_many :enrollments
  # Avoid an N+1 query by using a has_many, :through relationship
  # With :source, we're telling Rails to look for an association called :courses on the Enrollment model (as that's the model used for :enrollment)(?)
  # Does the same thing as this code, but in a single lookup instead of going through all enrollments and returning each course:
  # enrolled_courses = enrollments.collect do |enrollment|
  #     enrollment.course
  # end
  has_many :enrolled_courses, :through => :enrollments, :source => :course
  # enrolled_courses =,  enrollments.collect do |enrollmenbt|,  enrollment.course

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def enrolled_in?(course)
    return enrolled_courses.include?(course)
  end
end
