# Form implementation generated from reading ui file 'mget.ui'
#
# Created: nie wrz 30 14:13:09 2007
#      by: The QtRuby User Interface Compiler (rbuic)
#
# WARNING! All changes made in this file will be lost!


require 'Qt'

class MovieGetGui < Qt::Dialog

    slots 'languageChange()',
    'slotPopulateTargets()',
    'slotGetTargets()',
    'slotOpenTarget()',
    'slotCleanup()'

    attr_reader :targetEdit
    attr_reader :targetOpen
    attr_reader :targetAdd
    attr_reader :targetList
    attr_reader :modeGroup
    attr_reader :radioShow
    attr_reader :radioDownload
    attr_reader :radioDownloadConvert
    attr_reader :radioConvertRemove
    attr_reader :targetClear
    attr_reader :targetGet


    def initialize(parent = nil, name = nil, modal = false, fl = 0)
        super

        if name.nil?
        	setName("MovieGetGui")
        end

        @MovieGetGuiLayout = Qt::VBoxLayout.new(self, 11, 6, 'MovieGetGuiLayout')

        @layout1 = Qt::HBoxLayout.new(nil, 0, 6, 'layout1')

        @targetEdit = Qt::LineEdit.new(self, "targetEdit")
        @layout1.addWidget(@targetEdit)

        @targetOpen = Qt::ToolButton.new(self, "targetOpen")
        @layout1.addWidget(@targetOpen)

        @targetAdd = Qt::PushButton.new(self, "targetAdd")
        @layout1.addWidget(@targetAdd)
        @MovieGetGuiLayout.addLayout(@layout1)

        @targetList = Qt::ListView.new(self, "targetList")
        @targetList.addColumn(trUtf8("URL"))
        @MovieGetGuiLayout.addWidget(@targetList)

        @layout3 = Qt::HBoxLayout.new(nil, 0, 6, 'layout3')

        @modeGroup = Qt::ButtonGroup.new(self, "modeGroup")
        @modeGroup.setColumnLayout( 0, Qt::Vertical )
        @modeGroup.layout().setSpacing(6)
        @modeGroup.layout().setMargin(11)
        @modeGroupLayout = Qt::VBoxLayout.new(@modeGroup.layout() )
        @modeGroupLayout.setAlignment( AlignTop )

        @radioShow = Qt::RadioButton.new(@modeGroup, "radioShow")
        @modeGroupLayout.addWidget(@radioShow)

        @radioDownload = Qt::RadioButton.new(@modeGroup, "radioDownload")
        @radioDownload.setChecked( true )
        @modeGroupLayout.addWidget(@radioDownload)

        @radioDownloadConvert = Qt::RadioButton.new(@modeGroup, "radioDownloadConvert")
        @modeGroupLayout.addWidget(@radioDownloadConvert)

        @radioConvertRemove = Qt::RadioButton.new(@modeGroup, "radioConvertRemove")
        @modeGroupLayout.addWidget(@radioConvertRemove)
        @layout3.addWidget(@modeGroup)

        @layout35 = Qt::VBoxLayout.new(nil, 0, 6, 'layout35')

        @targetClear = Qt::PushButton.new(self, "targetClear")
        @layout35.addWidget(@targetClear)

        @targetGet = Qt::PushButton.new(self, "targetGet")
        @layout35.addWidget(@targetGet)
        @layout3.addLayout(@layout35)
        @MovieGetGuiLayout.addLayout(@layout3)
        languageChange()
        resize( Qt::Size.new(590, 470).expandedTo(minimumSizeHint()) )
        clearWState( WState_Polished )

        Qt::Object.connect(@targetAdd, SIGNAL("clicked()"), self, SLOT("slotPopulateTargets()") )
        Qt::Object.connect(@targetGet, SIGNAL("clicked()"), self, SLOT("slotGetTargets()") )
        Qt::Object.connect(@targetOpen, SIGNAL("clicked()"), self, SLOT("slotOpenTarget()") )
        Qt::Object.connect(@targetClear, SIGNAL("clicked()"), @targetList, SLOT("clear()") )
        Qt::Object.connect(@targetClear, SIGNAL("clicked()"), self, SLOT("slotCleanup()") )
    end

    #
    #  Sets the strings of the subwidgets using the current
    #  language.
    #
    def languageChange()
        setCaption(trUtf8("Ruby Movie Get"))
        @targetOpen.setText( trUtf8("...") )
        @targetAdd.setText( trUtf8("&Add") )
        @targetAdd.setAccel( Qt::KeySequence.new(trUtf8("Alt+A")) )
        @targetList.header().setLabel( 0, trUtf8("URL") )
        @modeGroup.setTitle( trUtf8("Mode") )
        @radioShow.setText( trUtf8("&show") )
        @radioShow.setAccel( Qt::KeySequence.new(trUtf8("Alt+S")) )
        Qt::ToolTip.add( @radioShow, trUtf8("Prevents downloading the file. Just shows the direct download url.") )
        @radioDownload.setText( trUtf8("&download") )
        @radioDownload.setAccel( Qt::KeySequence.new(trUtf8("Alt+D")) )
        Qt::ToolTip.add( @radioDownload, trUtf8("Download all files") )
        @radioDownloadConvert.setText( trUtf8("download && &convert") )
        @radioDownloadConvert.setAccel( Qt::KeySequence.new(trUtf8("Alt+C")) )
        Qt::ToolTip.add( @radioDownloadConvert, trUtf8("Download all files and convert .flv files") )
        @radioConvertRemove.setText( trUtf8("convert && &remove") )
        @radioConvertRemove.setAccel( Qt::KeySequence.new(trUtf8("Alt+R")) )
        Qt::ToolTip.add( @radioConvertRemove, trUtf8("Downloads all files, converts all .flv files and removes leftover files from conversion.") )
        @targetClear.setText( trUtf8("Clear") )
        @targetClear.setAccel( Qt::KeySequence.new(nil) )
        Qt::ToolTip.add( @targetClear, trUtf8("clear the list of targets") )
        @targetGet.setText( trUtf8("&Get All") )
        @targetGet.setAccel( Qt::KeySequence.new(trUtf8("Alt+G")) )
    end
    protected :languageChange


    def slotPopulateTargets(*k)
        print("MovieGetGui.slotPopulateTargets(): Not implemented yet.\n")
    end

    def slotGetTargets(*k)
        print("MovieGetGui.slotGetTargets(): Not implemented yet.\n")
    end

    def slotOpenTarget(*k)
        print("MovieGetGui.slotOpenTarget(): Not implemented yet.\n")
    end

    def slotCleanup(*k)
        print("MovieGetGui.slotCleanup(): Not implemented yet.\n")
    end

end
