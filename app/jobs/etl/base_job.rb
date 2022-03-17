class Etl::BaseJob < ApplicationJob
  queue_as :default

  def perform(*args)
    set_keys(*args)
    extract
    transform
    load
  end

  private

  # set params, set up variables to access data
  def set_keys(*args)
    @args = args
    @extracted_data = nil
    @transformed_data = nil
    @loaded_data = nil
  end

  # perform data fetching here
  def extract
    puts 'extracting...'
    # raise NotImplementedError, "must define an extract method"
  end

  # perform any data formatting or cleanup
  def transform
    puts 'transforming...'
    # raise NotImplementedError, "must define a transform method"
  end

  # save data to the database
  def load
    puts 'loading...'
    # raise NotImplementedError, "must define a load method"
  end
end
