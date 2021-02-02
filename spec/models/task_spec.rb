require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      expect(build(:task)).to be_valid
    end

    it 'is invalid without title' do
      task_without_title = build(:task, title: nil)
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without status' do
      task_without_status = build(:task, status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]).to include("can't be blank")
    end

    it 'is invalid with a duplicate title' do
      create(:task)
      task_with_duplicated_title = build(:task)
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]).to include("has already been taken")
    end

    it 'is valid with another title' do
      create(:task)
      expect(build(:task, title: "title02")).to be_valid
    end
  end
end
