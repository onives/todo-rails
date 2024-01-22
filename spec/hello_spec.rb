class Greeter 
    def greet 
        "Hello User!"
    end
end

describe "Greeter" do
    it "should greet a user" do
        subject = Greeter.new
        expect(subject.greet).to eql("Hello User!")
    end
end