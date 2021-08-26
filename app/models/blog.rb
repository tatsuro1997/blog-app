class Blog < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  has_rich_text :content
end
