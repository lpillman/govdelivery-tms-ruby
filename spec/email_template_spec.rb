require 'spec_helper'
require 'pry'

describe TMS::EmailTemplate do
  context "creating a list of email templates" do
    let(:client) do
      double('client')
    end
    before do
      @templates = TMS::EmailTemplates.new(client, '/templates/email')
    end

    it 'should be able to get a list of email templates' do
      response = [
        {
        'id'                         => "1",
        'body'                       => "Template 1",
        'subject'                    => "This is the template 1 subject",
        'link_tracking_parameters'   => "test=ok&hello=world",
        'macros'                     => {"MACRO1" => "1"},
        'open_tracking_enabled'      => true,
        'click_tracking_enabled'     => true,
        'created_at'                 => "sometime",
        '_links'                     => {"self" => "/templates/email/1","account" => "/accounts/1","from_address" => "/from_addresses/1"}
        }
      ]

      @templates.client.should_receive('get').with('/templates/email').and_return(double('response', :status => 200, :body => response, :headers => {}))
      @templates.get
      @templates.collection.length.should == 1
    end
  end

  context "creating an email template" do
    let(:client) do
      double('client')
    end
    before do
      @template = TMS::EmailTemplate.new(client, '/templates/email', {
        :body                       => "Template 1",
        :subject                    => "This is the template 1 subject",
        :link_tracking_parameters   => "test=ok&hello=world",
        :macros                     => {"MACRO1" => "1"},
        :open_tracking_enabled      => true,
        :click_tracking_enabled     => true,
      })
    end

    it 'should render linkable attrs in json hash' do
      @template.links[:from_address] = "1"
      @template.links[:invalid] = "2"
      links = @template.to_json[:_links]
      links[:from_address].should == '1'
      links[:invalid].should be_nil
    end

    it 'should clear the links property after a successful post' do
      @template.links[:from_address] = "1"
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 201, :body => {}))
      @template.post
      links = @template.to_json[:_links]
      links[:from_address].should be_nil
    end

    it 'should not clear the links property after an invalid post' do
      @template.links[:from_address] = "1"
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 400, :body => {}))
      @template.post
      links = @template.to_json[:_links]
      links[:from_address].should == "1"
    end

    it 'should post successfully' do
      response = {
        'id'                         => "1",
        'body'                       => "Template 1",
        'subject'                    => "This is the template 1 subject",
        'link_tracking_parameters'   => "test=ok&hello=world",
        'macros'                     => {"MACRO1" => "1"},
        'open_tracking_enabled'      => true,
        'click_tracking_enabled'     => true,
        'created_at'                 => "sometime",
        '_links'                     => {"self" => "/templates/email/1","account" => "/accounts/1","from_address" => "/from_addresses/1"}
      }
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 201, :body => response))
      @template.post
      @template.id.should                                == '1'
      @template.body.should                              == 'Template 1'
      @template.subject.should                           == 'This is the template 1 subject'
      @template.link_tracking_parameters.should          == 'test=ok&hello=world'
      @template.macros.should                            == {"MACRO1"=>"1"}
      @template.open_tracking_enabled.should             == true
      @template.click_tracking_enabled.should            == true 
      @template.created_at.should                        == 'sometime'
      @template.from_address.should                      be_a(TMS::FromAddress)
    end
  end


  context "handling errors at the template level" do
    let(:client) do
      double('client')
    end
    before do
      @template = TMS::EmailTemplate.new(client, '/templates/email/1')
    end

    it 'should handle errors' do
      response = {'errors' => {:body => "can't be nil"}}
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 422, :body => response))
      @template.post
      @template.errors.should == {:body => "can't be nil"}
    end

    it 'should handle 401 errors' do
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 401))
      expect {@template.post}.to raise_error("401 Not Authorized")
    end

    it 'should handle 404 errors' do
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 404))
      expect {@template.post}.to raise_error("Can't POST to /templates/email/1")
    end
  end  

  context "handling errors at the email_templates root level" do
    let(:client) do
      double('client')
    end
    before do
      @template = TMS::EmailTemplate.new(client, '/templates/email')
    end

    it 'should handle errors' do
      response = {'errors' => {:body => "can't be nil"}}
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 422, :body => response))
      @template.post
      @template.errors.should == {:body => "can't be nil"}
    end

    it 'should handle 401 errors' do
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 401))
      expect {@template.post}.to raise_error("401 Not Authorized")
    end

    it 'should handle 404 errors' do
      @template.client.should_receive('post').with(@template).and_return(double('response', :status => 404))
      expect {@template.post}.to raise_error("Can't POST to /templates/email")
    end
  end


end