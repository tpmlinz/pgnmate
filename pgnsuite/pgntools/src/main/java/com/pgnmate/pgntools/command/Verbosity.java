package com.pgnmate.pgntools.command;

public enum Verbosity {
	
		NORMAL("normal mode", "normsl mode", "n"),
		QUIET("quiet mode", "quiet", "q"),
		DIAGNOSTIC("diagnostice mode", "diagnostic", "d");
	
		private final String description;
		private final String longOpt;
		private final String shortOpt;
	
		private Verbosity(String description, String longOpt, String shortOpt) {
			this.description = description;
			this.longOpt = longOpt;
			this.shortOpt = shortOpt;
			
		}

		public String getDescription() { return description; }
		public String getLongOpt() { return longOpt; }
		public String shortOpt() { return shortOpt; }
		public int getChar() { return shortOpt.charAt(0); }
}
