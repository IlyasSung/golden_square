require "secret_diary"
require "diary"

RSpec.describe "integration" do
    context "initially" do
        it "does not read because diary is locked" do
            diary = Diary.new("MY CONTENTS")
            secret_diary = SecretDiary.new(diary)
            expect { secret_diary.read }.to raise_error "Go away!"
        end
    end

    context "when it unlocks" do
        it "does read because diary is unlocked" do
            diary = Diary.new("MY CONTENTS")
            secret_diary = SecretDiary.new(diary)
            secret_diary.unlock
            expect(secret_diary.read).to eq "MY CONTENTS"
        end
    end

    context "when it relocked" do
        it "does not read because diary is locked" do
            diary = Diary.new("MY CONTENTS")
            secret_diary = SecretDiary.new(diary)
            secret_diary.unlock
            secret_diary.lock
            expect { secret_diary.read }.to raise_error "Go away!"
        end
    end
end