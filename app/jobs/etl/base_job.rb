class Etl::BaseJob < ApplicationJob
  queue_as :default

  def initialize(*args)
    @args = args
    @extracted_data = nil
    @transformed_data = nil
    @loaded_data = nil
  end

  def perform(*args)
    extract
    transform
    load
  end

  private

  # perform data fetching here
  def extract
    raise NotImplementedError, "must define an extract method"
  end

  # perform any data formatting or cleanup
  def transform
    raise NotImplementedError, "must define a transform method"
  end

  # save data to the database
  def load
    raise NotImplementedError, "must define a load method"
  end
end
