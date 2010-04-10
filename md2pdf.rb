#!/usr/bin/ruby

require 'rdiscount'
require 'htmldoc'

pdf = PDF::HTMLDoc.new

pdf.set_option :outfile, "./outfile.pdf"
pdf.set_option :bodycolor, :white
pdf.set_option :toc, false
pdf.set_option :portrait, true
pdf.set_option :links, false
pdf.set_option :webpage, true
pdf.set_option :left, '2cm'
pdf.set_option :right, '2cm'

pdf.header ".t."
md = RDiscount.new(File.read(ARGV[0]), :smart)
pdf << md.to_html

pdf.footer ".1."

if pdf.generate
  puts "Successfully generated a PDF file"
end

