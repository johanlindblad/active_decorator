require 'spec_helper'

describe ActiveDecorator::Decorator do
  subject do
    ActiveDecorator::Decorator.instance
  end

  describe '#decorate' do
    context 'Mongoid::Criteria' do
      let(:criteria) {Mongoid::Criteria.new(MongoidDummy)}

      it 'is extended with ORM::Mongoid' do
        criteria.should_receive(:extend).with(ActiveDecorator::ORM::Mongoid)
        subject.decorate(criteria)
      end
    end
  end


  describe '#decorator_for' do
    context 'when a decorator exists' do
      it 'returns the decorator' do
        subject.send(:decorator_for, Parent).should == ParentDecorator
      end
    end

    context 'when a parent decorator exists' do
      it 'returns the decorator' do
        subject.send(:decorator_for, Child).should == ParentDecorator
      end
    end
  end
end

class Parent
end

class Child < Parent
end

module ParentDecorator
end

class MongoidDummy
  include Mongoid::Document
end

module MongoidDummyDecorator
end
