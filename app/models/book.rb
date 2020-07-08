class Book < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }
    
      # 「has_many」と「belogns_to」で1対Nの関係を作れる。今回は、userのidとbooksのuser_idを紐づけたいので、このような書き方。
    belongs_to :user

end
