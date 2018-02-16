require "rails_helper"

RSpec.describe OrderedCommentsQuery, type: :model do
  describe "#all" do
    subject { query_object.all.pluck(:id) }

    let!(:x) { create(:comment, likes_count: 3) }
    let!(:y) { create(:comment, likes_count: 5) }
    let!(:z) { create(:comment, likes_count: 1) }

    let(:query_object) { OrderedCommentsQuery.new(relation, sort: sort) }
    let(:relation) { Comment.all }

    context "sort is oldest" do
      let(:sort) { "oldest" }
      it { is_expected.to match_array [x, y, z].map(&:id) }
    end

    context "sort is newest" do
      let(:sort) { "newest" }
      it { is_expected.to match_array [z, y, x].map(&:id) }
    end

    context "sort is most_liked" do
      let(:sort) { "most_liked" }
      it { is_expected.to match_array [y, x, z].map(&:id) }
    end
  end
end
