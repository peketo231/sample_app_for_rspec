require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      expect(FactoryBot.build(:task)).to be_valid
    end

    it 'is invalid without title' do
      task = FactoryBot.build(:task, title: nil)
      expect(task.errors[:title]).to be_invalid include("can't be blank")
    end

    it 'is invalid without status' do
      task = FactoryBot.build(:task, status: nil)
      expect(task.errors[:status]).to be_invalid include("can't be blank")
    end

    it 'is invalid with a duplicate title' do
      FactoryBot.create(:task)
      task = FactoryBot.build(:task)
      expect(task.errors[:title]).to be_invalid include("has already been taken")
    end

    it 'is valid with another title' do
      FactoryBot.create(:task)
      expect(FactoryBot.build(:task, title: "title02")).to be_valid
    end
  end
end
