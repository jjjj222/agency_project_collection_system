require 'spec_helper'

describe PresenterBase do
  class Test
    present_obj :string

    present_with :rstrip, :capitalize
  end

  let(:string) { "test " }
  let(:presenter) { Test.new string }

  describe "present_obj" do
    it "should make the underlying object accessible via :object" do
      expect(presenter.object).to eq(string)
    end
    it "should make the underlying object accessible via :string" do
      expect(presenter.string).to eq(string)
    end
  end

  describe "present_with" do
    it "should capitalize the string and strip right whitespace" do
      expect(presenter.capitalize).to eq("Test")
    end
  end
end
