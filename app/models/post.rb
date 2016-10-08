class Post < ActiveRecord::Base

    validates :title, :url, :user_id, presence: true

    has_many :post_subs, inverse_of: :post, dependent: :destroy
    has_many :subs, through: :post_subs, source: :sub

end
