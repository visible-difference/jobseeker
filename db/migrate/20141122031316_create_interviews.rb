class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :interview_date
      t.string :notes
      t.belongs_to :job, index: true
    end
  end
end