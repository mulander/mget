# Form implementation generated from reading ui file 'accountinfo.ui'
#
# Created: sob wrz 29 17:09:02 2007
#      by: The QtRuby User Interface Compiler (rbuic)
#
# WARNING! All changes made in this file will be lost!


require 'Qt'

class AccountInfoForm < Qt::Dialog

    slots 'languageChange()',
    'slotSaveInfo()'

    attr_reader :infoLabel
    attr_reader :usernameLabel
    attr_reader :passwordLabel
    attr_reader :usernameEdit
    attr_reader :passwordEdit
    attr_reader :rememberPassword
    attr_reader :buttonAbort
    attr_reader :buttonOK


    def initialize(parent = nil, name = nil, modal = false, fl = 0)
        super

        if name.nil?
        	setName("AccountInfoForm")
        end

        @AccountInfoFormLayout = Qt::VBoxLayout.new(self, 11, 6, 'AccountInfoFormLayout')

        @layout12 = Qt::VBoxLayout.new(nil, 0, 6, 'layout12')
        @spacer2 = Qt::SpacerItem.new(20, 40, Qt::SizePolicy::Minimum, Qt::SizePolicy::Expanding)
        @layout12.addItem(@spacer2)

        @layout11 = Qt::HBoxLayout.new(nil, 0, 6, 'layout11')
        @spacer4 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)
        @layout11.addItem(@spacer4)

        @infoLabel = Qt::Label.new(self, "infoLabel")
        @layout11.addWidget(@infoLabel)
        @spacer3 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)
        @layout11.addItem(@spacer3)
        @layout12.addLayout(@layout11)
        @spacer1 = Qt::SpacerItem.new(20, 40, Qt::SizePolicy::Minimum, Qt::SizePolicy::Expanding)
        @layout12.addItem(@spacer1)
        @AccountInfoFormLayout.addLayout(@layout12)

        @layout21 = Qt::HBoxLayout.new(nil, 0, 6, 'layout21')

        @layout20 = Qt::VBoxLayout.new(nil, 0, 6, 'layout20')

        @layout19 = Qt::HBoxLayout.new(nil, 0, 6, 'layout19')

        @usernameLabel = Qt::Label.new(self, "usernameLabel")
        @layout19.addWidget(@usernameLabel)
        @spacer5 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)
        @layout19.addItem(@spacer5)
        @layout20.addLayout(@layout19)

        @layout17 = Qt::HBoxLayout.new(nil, 0, 6, 'layout17')

        @passwordLabel = Qt::Label.new(self, "passwordLabel")
        @layout17.addWidget(@passwordLabel)
        @spacer6 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)
        @layout17.addItem(@spacer6)
        @layout20.addLayout(@layout17)
        @layout21.addLayout(@layout20)

        @layout13 = Qt::VBoxLayout.new(nil, 0, 6, 'layout13')

        @usernameEdit = Qt::LineEdit.new(self, "usernameEdit")
        @layout13.addWidget(@usernameEdit)

        @passwordEdit = Qt::LineEdit.new(self, "passwordEdit")
        @passwordEdit.setEchoMode( Qt::LineEdit::Password )
        @layout13.addWidget(@passwordEdit)
        @layout21.addLayout(@layout13)
        @AccountInfoFormLayout.addLayout(@layout21)

        @layout30 = Qt::HBoxLayout.new(nil, 0, 6, 'layout30')

        @rememberPassword = Qt::CheckBox.new(self, "rememberPassword")
        @layout30.addWidget(@rememberPassword)

        @buttonAbort = Qt::PushButton.new(self, "buttonAbort")
        @layout30.addWidget(@buttonAbort)

        @buttonOK = Qt::PushButton.new(self, "buttonOK")
        @layout30.addWidget(@buttonOK)
        @AccountInfoFormLayout.addLayout(@layout30)
        languageChange()
        resize( Qt::Size.new(517, 212).expandedTo(minimumSizeHint()) )
        clearWState( WState_Polished )

        Qt::Object.connect(@buttonOK, SIGNAL("clicked()"), self, SLOT("slotSaveInfo()") )
        Qt::Object.connect(@buttonAbort, SIGNAL("clicked()"), self, SLOT("reject()") )

        setTabOrder(@usernameEdit, @passwordEdit)
        setTabOrder(@passwordEdit, @rememberPassword)
        setTabOrder(@rememberPassword, @buttonOK)
        setTabOrder(@buttonOK, @buttonAbort)
    end

    #
    #  Sets the strings of the subwidgets using the current
    #  language.
    #
    def languageChange()
        setCaption(trUtf8("Account Information"))
        @infoLabel.setText( trUtf8("Youtube requires identification before downloading adult content.\n" +
        "If You want to be able to download this type of content then\n" +
        "please enter Your Youtube login information.") )
        @usernameLabel.setText( trUtf8("Username:") )
        @passwordLabel.setText( trUtf8("Password:") )
        @rememberPassword.setText( trUtf8("remember password\n" +
        "(not recommended!)") )
        @buttonAbort.setText( trUtf8("&Abort") )
        @buttonAbort.setAccel( Qt::KeySequence.new(trUtf8("Alt+A")) )
        @buttonOK.setText( trUtf8("&OK") )
        @buttonOK.setAccel( Qt::KeySequence.new(trUtf8("Alt+O")) )
    end
    protected :languageChange


    def slotSaveInfo(*k)
        print("AccountInfoForm.slotSaveInfo(): Not implemented yet.\n")
    end

end
