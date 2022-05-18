class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :recipes, dependent: :destroy
  has_many :foods, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false },
                   presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }

  def admin?
    role == 'admin'
  end
end
