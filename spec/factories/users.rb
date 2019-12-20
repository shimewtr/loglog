# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "testuser" }
    email { "test@hoge.hoge" }
    password { "secret" }
    password_confirmation { "secret" }
    admin { false }
    salt { salt = "asdasdastr4325234324sdfds" }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
    after(:create) { |user| user.activate! }
  end
end
