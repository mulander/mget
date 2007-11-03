# Form implementation generated from reading ui file 'mgetoutput.ui'
#
# Created: sob wrz 29 22:15:55 2007
#      by: The QtRuby User Interface Compiler (rbuic)
#
# WARNING! All changes made in this file will be lost!


require 'Qt'

class MgetOutput < Qt::Dialog

    attr_reader :outputEdit
    attr_reader :buttonSelectAll
    attr_reader :buttonCopy


    def initialize(parent = nil, name = nil, modal = false, fl = 0)
        super

        if name.nil?
        	setName("MgetOutput")
        end
        setEnabled(true)

        @MgetOutputLayout = Qt::VBoxLayout.new(self, 11, 6, 'MgetOutputLayout')

        @layout39 = Qt::VBoxLayout.new(nil, 0, 6, 'layout39')

        @outputEdit = Qt::TextEdit.new(self, "outputEdit")
        @outputEdit.setEnabled( true )
        @layout39.addWidget(@outputEdit)

        @layout38 = Qt::HBoxLayout.new(nil, 0, 6, 'layout38')

        @buttonSelectAll = Qt::PushButton.new(self, "buttonSelectAll")
        @layout38.addWidget(@buttonSelectAll)

        @buttonCopy = Qt::PushButton.new(self, "buttonCopy")
        @layout38.addWidget(@buttonCopy)
        @layout39.addLayout(@layout38)
        @MgetOutputLayout.addLayout(@layout39)
        languageChange()
        resize( Qt::Size.new(797, 420).expandedTo(minimumSizeHint()) )
        clearWState( WState_Polished )

        Qt::Object.connect(@buttonSelectAll, SIGNAL("clicked()"), @outputEdit, SLOT("selectAll()") )
        Qt::Object.connect(@buttonCopy, SIGNAL("clicked()"), @outputEdit, SLOT("copy()") )
    end

    #
    #  Sets the strings of the subwidgets using the current
    #  language.
    #
    def languageChange()
        setCaption(trUtf8("Ruby Movie Get - Output"))
        @buttonSelectAll.setText( trUtf8("Select All") )
        @buttonCopy.setText( trUtf8("Copy to Clipboard") )
    end
    protected :languageChange


end
