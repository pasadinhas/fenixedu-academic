/*
 * SeccaoOJB.java
 *
 * Created on 23 de Agosto de 2002, 16:58
 */

package ServidorPersistente.OJB;

/**
 *
 * @author  ars
 */

import java.util.List;

import org.odmg.QueryException;

import Dominio.ISection;
import Dominio.ISite;
import Dominio.Section;
import ServidorPersistente.ExcepcaoPersistencia;
import ServidorPersistente.IPersistentSection;

public class SectionOJB extends ObjectFenixOJB implements IPersistentSection {

	/** Creates a new instance of SeccaoOJB */
	public SectionOJB() {
	}

	public ISection readBySiteAndSectionAndName(
		ISite site,
		ISection superiorSection,
		String name)
		throws ExcepcaoPersistencia {
		try {
			
			ISection resultSection = null;
			Section section = (Section) superiorSection;
			String oqlQuery = "select section from " + Section.class.getName();
			oqlQuery += " where name = $1 ";
			oqlQuery +=	" and site.executionCourse.sigla = $2";
			oqlQuery += " and site.executionCourse.executionPeriod.name = $3";
			oqlQuery += " and site.executionCourse.executionPeriod.executionYear.year = $4";
			if (section == null) {
				
				oqlQuery += " and is_undefined(keySuperiorSection) " ;
				
			} else {
				
				oqlQuery += " and keySuperiorSection = $5";
				}

			query.create(oqlQuery);
			
			query.bind(name);
			query.bind(site.getExecutionCourse().getSigla());
			query.bind(site.getExecutionCourse().getExecutionPeriod().getName());
			query.bind(site.getExecutionCourse().getExecutionPeriod().getExecutionYear().getYear());
			
			if (section != null) {
				System.out.println("Estou Aqui");
				System.out.println(oqlQuery);
				query.bind(section.getInternalCode());			
			}

			List result = (List) query.execute();
			lockRead(result);
			if (result.size() != 0)
				resultSection = (ISection) result.get(0);
			return resultSection;
		} catch (QueryException queryEx) {
			throw new ExcepcaoPersistencia(ExcepcaoPersistencia.QUERY, queryEx);
		}
	}

	public void lockWrite(ISection section) throws ExcepcaoPersistencia {
		super.lockWrite(section);
	}

	public void delete(ISection section) throws ExcepcaoPersistencia {
		super.delete(section);
	}

	public void deleteAll() throws ExcepcaoPersistencia {
		String oqlQuery = "select all from " + Section.class.getName();
		super.deleteAll(oqlQuery);
	}

}
