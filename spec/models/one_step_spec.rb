describe OneStep do

it { should have_many :companies }
it { should have_many(:contacts).through(:companies) }
it { should have_many(:jobs).through(:companies) }

end