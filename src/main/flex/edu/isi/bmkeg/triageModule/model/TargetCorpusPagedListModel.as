package edu.isi.bmkeg.triageModule.model
{
	import edu.isi.bmkeg.pagedList.model.PagedListModel;
	
	public class TargetCorpusPagedListModel extends PagedListModel
	{
		
		public static var LIST_ID = "targetCorpusList"

		public function TargetCorpusPagedListModel()
		{
			super();
			this.id = LIST_ID;
		}
	}
}