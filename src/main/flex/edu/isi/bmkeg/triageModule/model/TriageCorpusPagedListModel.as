package edu.isi.bmkeg.triageModule.model
{
	import edu.isi.bmkeg.pagedList.model.PagedListModel;
	
	public class TriageCorpusPagedListModel extends PagedListModel
	{
		public static var LIST_ID = "triageCorpusList"
		
		public function TriageCorpusPagedListModel()
		{
			super();
			this.id = LIST_ID;
		}
	}
}