class FolderGroup
  include Mongoid::Document
  field :name
  field :sort, :type => Integer, :default => 0
  field :image_path

  belongs_to :user
  has_many :folders, dependent: :nullify
  
  validates_presence_of :name
end