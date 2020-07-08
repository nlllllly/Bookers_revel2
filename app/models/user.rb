class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # validatesで、入力規則にルールをつけている。presenceはblankでもOKかどうかで、「true」はエラーが表示される。「false」だと空でもOK。
  # uniqelessは、カラム内の他の値と重複していないか確認してくれる。
  # lengthは入力の長さを決めてくれる。
  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, presence: false, length: { maximum: 50 }

  # 「has_many」と「belogns_to」で1対Nの関係を作れる。今回は、userのidとbooksのuser_idを紐づけたいので、このような書き方。
  has_many :books, dependent: :destroy
  attachment :profile_image
end
