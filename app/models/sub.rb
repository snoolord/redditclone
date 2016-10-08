class Sub < ActiveRecord::Base

  validates :moderator_id, :description, presence: true
  validates :name, presence: true, uniqueness: true

  has_many :post_subs,
    class_name: :PostSub,
    primary_key: :id,
    foreign_key: :sub_id

  has_many :posts,
    through: :post_subs,
    source: :post

  belongs_to :moderator,
    class_name: :User,
    primary_key: :id,
    foreign_key: :moderator_id

end
