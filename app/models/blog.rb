class Blog < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_one_attached :avatar

  has_rich_text :content

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_blog_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_blog_tag
    end
  end
end
