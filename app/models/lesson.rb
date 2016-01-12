class Lesson < ActiveRecord::Base
  belongs_to :section
  mount_uploader :video, VideoUploader

  include RankedModel
  ranks :row_order, :with_same => :section_id

  def next_lesson
    # We are asking for records where the row_order, the field that the RankedModel gem is using to position the lesson in the database, is greater than what we specify. The question mark indicates we will be passing through an additional value in a moment (self.row_order)
    # In total, where("row_order > ?", self.row_order) filters out all of the lessons that are not after the current lesson in the section.  Then we can just call the first lesson by :row_order ranking.
    lesson = section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first

    # If there is no next lesson within the current section and there is a next section, return the first lesson within the next section:
    if lesson.blank? && section.next_section
      return section.next_section.lessons.rank(:row_order).first
    end

    return lesson
  end
end
