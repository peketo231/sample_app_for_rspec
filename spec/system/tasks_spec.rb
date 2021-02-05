require 'rails_helper'

RSpec.describe "Tasks", type: :system, focus: true do

  describe 'ログイン前' do
    describe 'タスク新規登録' do
      context 'ログインしていない状態' do
        it '新規作成ページへのアクセスが失敗する' do
          visit new_task_path
          expect(current_path).to eq login_path
          expect(page).to have_content "Login required"
        end
      end
    end

    describe 'タスク編集' do
      context 'ログインしていない状態' do
        it '編集ページへのアクセスが失敗する' do
          task = create(:task)
          visit edit_task_path(task)
          expect(current_path).to eq login_path
          expect(page).to have_content "Login required"
        end
      end
    end
  end

  describe 'ログイン後' do
    describe 'タスク新規登録' do
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成が成功する' do
          user = create(:user)
          login(user)
          click_link 'New Task'
          fill_in 'Title', with: 'title'
          fill_in 'Content', with: 'content'
          select 'todo', from: 'Status'
          fill_in 'Deadline', with: '002021-03-31-00:00'
          click_button 'Create Task'
          expect(current_path).to eq task_path(user)
          expect(page).to have_content "Task was successfully created."
        end
      end
    end

    describe 'タスク編集' do
      context 'フォームの入力値が正常' do
        it 'タスクの編集が成功する' do
          task = create(:task)
          login(task.user)
          click_link 'Edit'
          fill_in 'Title', with: 'title'
          fill_in 'Content', with: 'content'
          select 'todo', from: 'Status'
          fill_in 'Deadline', with: '002021-03-31-00:00'
          click_button 'Update Task'
          expect(current_path).to eq task_path(task.user)
          expect(page).to have_content "Task was successfully updated."
        end
      end
      context '他ユーザーのタスク編集ページにアクセス' do
        it 'タスク編集ページへのアクセスが失敗する' do
          user = create(:user)
          another_task = create(:task)
          login(user)
          visit edit_task_path(another_task)
          expect(current_path).to eq root_path
          expect(page).to have_content "Forbidden access."
        end
      end
    end

    describe 'タスク削除' do
      context 'タスクを削除' do
        it 'タスクの削除が成功する' do
          task = create(:task)
          login(task.user)
          click_link 'Destroy'
          expect(page.accept_confirm).to eq "Are you sure?"
          expect(current_path).to eq tasks_path
          expect(page).to have_content "Task was successfully destroyed."
        end
      end
    end
  end
end
