require 'helper'

describe ChristmasTree::Ornament do

  let(:model) { double("Model", name: "Grinch", size: "2 sizes too small") }

  describe "#initialize" do
    it "requires a model" do
      ChristmasTree::Ornament.should_receive(:new).with(model)
      ChristmasTree::Ornament.new(model)
    end

    it "exposes model" do
      ornament = ChristmasTree::Ornament.new(model)
      expect(ornament.model).to be model
    end
  end

  describe "allows method specific delegation" do
    let(:decorator) do
      class Decorator < ChristmasTree::Ornament
        delegate :name, to: :model
      end
      Decorator.new(model)
    end

    it "delegates things" do
      expect(decorator.name).to eq("Grinch")
    end
  end

  describe "allows setting of presenter classes" do
    let(:decorator) do
      class GrinchDecorator < ChristmasTree::Ornament
        presents :html
      end
      GrinchDecorator.new(model)
    end

    let!(:presenter) do
      class GrinchPresenter < ChristmasTree::WrappingPaper
        def to_html
          "heart grew #{model.size.to_i + 2} sizes that day"
        end
      end
    end

    it "finds presenter by name convention" do
      expect(decorator.to_html).to eq("heart grew 4 sizes that day")
    end
  end
end
