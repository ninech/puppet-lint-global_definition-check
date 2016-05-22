require 'spec_helper'

describe 'global_resource' do
  
  context 'just a class' do
    let(:code) { "class test { file { 'file': } }" }
    
    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'just a define' do
    let(:code) { "define test ($param = undef) { file { 'file': } }" }

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'allow node resources' do
    let(:code) { "node 'test' { file { 'file': } }" }

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'global file' do
    let(:code) { "file { 'file': } define test ($param = undef) { file { 'file': } }" }

    it 'should detect a problem' do
      expect(problems).to have(1).problems
    end
  end

  context 'global includes' do
    let(:code) { "include class" }

    it 'should detect a problem' do
        expect(problems).to have(1).problems
    end
  end

end
