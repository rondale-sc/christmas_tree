require 'helper'

describe ChristmasTree::WrappingPaper do

  let(:decorator) { double("MyDecorator", name: "Grinch", size: "2 sizes too small") }
  let(:wrapping_paper) { ChristmasTree::WrappingPaper.new(decorator) }

  context :initialize do
    it "requires a decorator" do
      ChristmasTree::WrappingPaper.should_receive(:new).with(decorator)
      wrapping_paper
    end

    it "exposes its decorator" do
      expect(wrapping_paper.decorator).to eq(decorator)
    end
  end

  describe "delegation" do
    it "sends calls to model to its decorator" do
      expect(wrapping_paper.model.name).to eq("Grinch")
    end
  end

  describe "HTMLHelpers" do
    context "#tag" do
      let(:my_presenter) do
        Class.new(ChristmasTree::WrappingPaper) do
          def word
            "delicious"
          end

          def to_html
            tag(:h1) do
              "Egg nog"
              tag(:div) { "Heyo" }
              tag(:p) do
                "It's #{word}"
              end
            end
          end
        end.new(decorator)

      end

      it "prints html content" do
        expected = (<<-EOS).gsub(/\n/, "").gsub(/\s{2,}/, "")
        <h1>
          Egg nog
          <div>Heyo</div>
          <p>It's delicious</p>
        </h1>
        EOS

        expect(my_presenter.to_html).to eq(expected)
      end
    end
  end
end
