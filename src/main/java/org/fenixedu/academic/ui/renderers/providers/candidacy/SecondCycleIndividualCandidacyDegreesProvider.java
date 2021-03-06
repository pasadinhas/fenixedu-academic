/**
 * Copyright © 2002 Instituto Superior Técnico
 *
 * This file is part of FenixEdu Academic.
 *
 * FenixEdu Academic is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FenixEdu Academic is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with FenixEdu Academic.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.fenixedu.academic.ui.renderers.providers.candidacy;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

import org.fenixedu.academic.domain.AcademicProgram;
import org.fenixedu.academic.domain.Degree;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicOperationType;
import org.fenixedu.academic.domain.candidacyProcess.CandidacyProcess;
import org.fenixedu.academic.domain.candidacyProcess.secondCycle.SecondCycleCandidacyProcess;
import org.fenixedu.academic.domain.candidacyProcess.secondCycle.SecondCycleIndividualCandidacyProcessBean;
import org.fenixedu.academic.domain.degree.DegreeType;
import org.fenixedu.academic.ui.struts.action.candidacy.CandidacyProcessDA.ChooseDegreeBean;
import org.fenixedu.bennu.core.security.Authenticate;

import pt.ist.fenixWebFramework.rendererExtensions.converters.DomainObjectKeyConverter;
import pt.ist.fenixWebFramework.renderers.DataProvider;
import pt.ist.fenixWebFramework.renderers.components.converters.Converter;

import com.google.common.base.Predicate;
import com.google.common.collect.Collections2;

public class SecondCycleIndividualCandidacyDegreesProvider implements DataProvider {

    @Override
    public Object provide(Object source, Object currentValue) {

        final Set<AcademicProgram> programs =
                AcademicAccessRule.getProgramsAccessibleToFunction(AcademicOperationType.MANAGE_INDIVIDUAL_CANDIDACIES,
                        Authenticate.getUser()).collect(Collectors.toSet());

        return Collections2.filter(getDegrees(source), new Predicate<Degree>() {
            @Override
            public boolean apply(Degree degree) {
                return programs.contains(degree);
            }
        });
    }

    private Collection<Degree> getDegrees(Object source) {
        if (source instanceof SecondCycleIndividualCandidacyProcessBean) {
            final SecondCycleIndividualCandidacyProcessBean bean = (SecondCycleIndividualCandidacyProcessBean) source;
            return bean.getAvailableDegrees();
        }
        if (source instanceof ChooseDegreeBean) {
            final ChooseDegreeBean bean = (ChooseDegreeBean) source;
            final CandidacyProcess candidacyProcess = bean.getCandidacyProcess();
            if (candidacyProcess instanceof SecondCycleCandidacyProcess) {
                final SecondCycleCandidacyProcess secondCycleCandidacyProcess = (SecondCycleCandidacyProcess) candidacyProcess;
                return secondCycleCandidacyProcess.getAvailableDegrees();
            }
        }
        return Degree.readAllMatching(DegreeType.oneOf(DegreeType::isBolonhaMasterDegree, DegreeType::isIntegratedMasterDegree));
    }

    @Override
    public Converter getConverter() {
        return new DomainObjectKeyConverter();
    }

}
