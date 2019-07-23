FactoryBot.define do
  factory :product do
    name {"Producto1" }
    pricing {"9.99"}
    description {"Esta es una descripcion"}
    association :user, factory: :user
  end
end
