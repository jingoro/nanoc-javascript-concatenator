require 'nanoc/filters/javascript_concatenator'

describe Nanoc::Filters::JavascriptConcatenator do
  
  let(:first_path) { File.expand_path('../js/first.js', __FILE__) }
  let(:second_path) { File.expand_path('../js/second.js', __FILE__) }
  
  before do
    item = { :content_filename => File.expand_path('../foo.js', __FILE__) }
    subject.instance_variable_set(:@item, item)
    subject.instance_variable_set(:@items, []) # ignore dependency checking
  end

  it 'should ignore standard comments' do
    js = <<-JS
// free
// foo
/* some other comments
   blah blah
*/
  // blah
    JS
    subject.run(js).should == js
  end

  it 'should include a relative path' do
    js = <<-JS
// begin
// require js/first.js
// end
    JS
    subject.run(js).should == <<-JS
// begin

;var first = 1;

// end
    JS
  end

  it 'should include an absolute path' do
    js = <<-JS
// begin
// require #{first_path}
// end
    JS
    subject.run(js).should == <<-JS
// begin

;var first = 1;

// end
    JS
  end
  
  it 'should ignore missing files' do
    js = <<-JS
// begin
// require js/non-existent.js
// end
    JS
    subject.run(js).should == js
  end
  
  it 'should concatenate multiple files' do
    js = <<-JS
// begin
// require js/first.js
// require js/non-existent.js
// require #{second_path}
// end
    JS
    subject.run(js).should == <<-JS
// begin

;var first = 1;

// require js/non-existent.js

;var SECOND = 'yo';

// end
    JS
  end

end
