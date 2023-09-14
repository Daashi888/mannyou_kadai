require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do

        sleep 1
        visit new_tasks_path
        sleep 1

        fill_in 'text', with:'task'
        fill_in 'content', with:'task'

        click_on '新しくタスクを登録する' #onとlink違い調べる

        expect(page).to have_content 'task'

      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task)
        # タスク一覧ページに遷移
        sleep 1
        visit tasks_path
        sleep 1
        
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'test_title'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される

      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        FactoryBot.create(:task)

        sleep 1
        visit task_path(Task.last.id)
        sleep 1

        expect(page).to have_content 'task'

       end
     end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      visit tasks_path

      task_list = all('.task_row') 

      expect(page).to have_content
      end
    end
  end

  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, title: "task")
      FactoryBot.create(:second_task, title: "sample")
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        # 検索ボタンを押す
        fill_in 'task'
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        # プルダウンを選択する「select」について調べてみること
        FactoryBot.create(:task, title: "task1", status: '未着手')
        FactoryBot.create(:task, title: "task2", status: '着手中')
        FactoryBot.create(:task, title: "task3", status: '完了')

        visit tasks_path
        select '着手中', from: 'status'
        click_on '検索'

        expect(page).to have_content 'task2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        FactoryBot.create(:task, title: "task1", status: '未着手')
        FactoryBot.create(:task, title: "task2", status: '着手中')
        FactoryBot.create(:task, title: "task3", status: '完了')
        
        visit tasks_path
        fill_in 'search'
        select '完了', from: 'status'
        expect(page).to have_content 'task3'
      end
    end
  end
end
