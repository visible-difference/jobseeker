class Contact < ActiveRecord::Base
  belongs_to :company
  has_many :reminders, as: :rem
  has_many :followups, as: :follow

  validates :email, :format => { :with => /@/, :message => "Invalid email format" }
  validates_presence_of :first_name, :last_name

  before_save :text_style

  scope :by_last_name, -> {order(:last_name) }

private

  def text_style
    self.first_name = self.first_name.downcase.titleize
    self.last_name = self.last_name.downcase.titleize
    self.title = self.title.titleize
    self.email = self.email.downcase
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end