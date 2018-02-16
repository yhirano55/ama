require "rails_helper"

RSpec.describe OrderedIssuesQuery, type: :model do
  describe "#all" do
    subject { query_object.all.pluck(:id) }

    let!(:x) { create(:issue, comments_count: 2, likes_count: 3) }
    let!(:y) { create(:issue, comments_count: 1, likes_count: 5) }
    let!(:z) { create(:issue, comments_count: 3, likes_count: 1) }

    let(:query_object) { OrderedIssuesQuery.new(relation, sort: sort) }
    let(:relation) { Issue.all }

    context "sort is oldest" do
      let(:sort) { "oldest" }
      it { is_expected.to match_array [x, y, z].map(&:id) }
    end

    context "sort is newest" do
      let(:sort) { "newest" }
      it { is_expected.to match_array [z, y, x].map(&:id) }
    end

    context "sort is most_commented" do
      let(:sort) { "most_commented" }
      it { is_expected.to match_array [z, x, y].map(&:id) }
    end

    context "sort is most_liked" do
      let(:sort) { "most_liked" }
      it { is_expected.to match_array [y, x, z].map(&:id) }
    end
  end
end
