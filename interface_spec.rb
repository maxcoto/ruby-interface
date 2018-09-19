require "rails_helper"

RSpec.describe Interface do

  describe "code respects interface structure" do

    # we can put here models that does not respect the interface yet
    let(:excluded_models) {[
      OutreachPlugin,
      HubspotPlugin,
      SalesforcePlugin,
      PersistiqPlugin
    ]}

    before do
      Rails.application.eager_load!
      @models = Mongoid.models.select { |model| model.respond_to?(:needs_implementation) && model.subclasses.count > 0 }
    end

    it do
      @models.each do |model|
        submodels = model.subclasses - excluded_models
        model.interface_methods.each do |method, args|
          submodels.each do |submodel|
            expect(submodel.new).to respond_to(method).with(args.count).arguments
          end
        end
      end
    end
  end
end
