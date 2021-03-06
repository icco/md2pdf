#! /usr/bin/ruby

require 'redcarpet'
require 'htmldoc'

if ARGV.length != 2
   puts "md2pdf : Markdown to PDF converter."
   puts "usage  : md2pdf infile outfile"

   exit 1
end

infile = ARGV[0]
outfile = ARGV[1]

if !File.exists? infile
   puts "#{infile} does not exist."
   exit 2
end

if !File.exists? outfile
   puts "#{outfile} does not exist."
   exit 2
end

pdf = PDF::HTMLDoc.new
pdf.set_option :outfile, outfile
pdf.set_option :bodycolor, :white
pdf.set_option :toc, false
pdf.set_option :portrait, true
pdf.set_option :links, false
pdf.set_option :webpage, true
pdf.set_option :left, '2cm'
pdf.set_option :right, '2cm'

pdf.header ".t."
renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true)
markdown = Redcarpet::Markdown.new(renderer, extensions = {})
md = markdown.render(File.read(infile))

pdf << md

pdf.footer ".1."

if pdf.generate
  puts "Successfully generated a PDF file"
end

