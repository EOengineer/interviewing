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


  # TODO: These methods should live in a module
  # determines if new record should be created, or existing one updated.
  def create_or_update_record(record)
    raise 'must declare writable_attributes' if writable_attributes.blank?
    if record.new_record?
      record.save!
    else
      record.update!(populate_attributes(writable_attributes, record))
    end
  end

  # converts [my, hash, keys] => { my: record[my], team: record[hash], key: record[key] }
  def populate_attributes(attribute_array, record)
    attribute_array.to_h { |key| [key, record[key.to_sym]] }
  end

  # attributes used in the lookup of existing records
  # [:team, :name, :etc]
  def finder_attributes
    %i[]
  end

  # attributes that should be passed into the .update method for existing records
  # ['team', 'name', 'etc']
  def writable_attributes
    %w[]
  end
end
