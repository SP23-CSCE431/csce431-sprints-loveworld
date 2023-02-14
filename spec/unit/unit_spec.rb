# location: spec/unit/unit_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
        described_class.new(full_name: 'Brandon Longuet', 
                            email: 'brandon.longuet@yahoo.com',
                            phone_number: '1234567890')
  end

  it 'is valid with valid attributes' do
        subject.full_name = "Anything"
        subject.email = "Anything"
        subject.phone_number = "Anything"
        expect(subject).to be_valid
  end

  it 'is not valid without a name' do
        subject.full_name = nil
        expect(subject).not_to be_valid
  end
end

RSpec.describe Event, type: :model do
    subject do
        described_class.new(name: 'Brandon Longuet', 
                            start: Time.now,
                            end: Time.now + 3.days )
    end
  
    it 'is valid with valid attributes' do
        subject.name = "Anything"
        subject.start = Time.now
        subject.end = Time.now + 3.days
        expect(subject).to be_valid
    end
  
    it 'is not valid without attributes' do
        subject.name = nil
        subject.start = nil
        subject.end = nil
        expect(subject).not_to be_valid
    end
end

RSpec.describe Group, type: :model do
    subject do
        described_class.new(name: 'LoveWorld Staff', 
                            description: 'This if for the LoveWorld Staff')
    end

    it 'is valid with valid attributes' do
        subject.name = "Anything"
        subject.description = "Anything"
        expect(subject).to be_valid
    end

    it 'is not valid without a name and description' do
        subject.name = nil
        subject.description = nil
        expect(subject).not_to be_valid
    end
end
